# Reusable functions for Math 167R Project 1
# The last four digits of the student's ID are used as the reproducible seed.

STUDENT_SEED <- 2551
N_SIMULATIONS <- 10000
SAMPLE_SIZES <- c(2, 5, 10, 20, 30, 50, 100, 200)

# These are descriptive moment measures. Excess kurtosis is used so that a
# normal distribution has kurtosis approximately equal to zero.
skewness <- function(x) {
  x <- x[is.finite(x)]
  centered <- x - mean(x)
  mean(centered^3) / sd(x)^3
}

excess_kurtosis <- function(x) {
  x <- x[is.finite(x)]
  centered <- x - mean(x)
  mean(centered^4) / sd(x)^4 - 3
}

simulate_sample_means <- function(generator,
                                   sample_sizes = SAMPLE_SIZES,
                                   n_simulations = N_SIMULATIONS) {
  means_by_size <- vector("list", length(sample_sizes))
  names(means_by_size) <- as.character(sample_sizes)

  for (sample_size in sample_sizes) {
    means_by_size[[as.character(sample_size)]] <- replicate(
      n_simulations,
      mean(generator(sample_size))
    )
  }

  means_by_size
}

summarize_sample_means <- function(means_by_size,
                                   theoretical_mean = NA_real_,
                                   theoretical_sd = NA_real_) {
  rows <- lapply(names(means_by_size), function(size_name) {
    means <- means_by_size[[size_name]]
    sample_size <- as.numeric(size_name)

    theoretical_se <- if (is.na(theoretical_sd)) {
      NA_real_
    } else {
      theoretical_sd / sqrt(sample_size)
    }

    data.frame(
      sample_size = sample_size,
      simulated_mean = mean(means),
      simulated_sd = sd(means),
      theoretical_mean = theoretical_mean,
      theoretical_se = theoretical_se,
      skewness = skewness(means),
      excess_kurtosis = excess_kurtosis(means),
      abs_skewness = abs(skewness(means)),
      abs_excess_kurtosis = abs(excess_kurtosis(means)),
      screening_rule = abs(skewness(means)) <= 0.15 &&
        abs(excess_kurtosis(means)) <= 0.30,
      row.names = NULL
    )
  })

  do.call(rbind, rows)
}

print_summary <- function(summary_table, digits = 4) {
  displayed <- summary_table
  numeric_columns <- vapply(displayed, is.numeric, logical(1))
  displayed[numeric_columns] <- lapply(
    displayed[numeric_columns],
    round,
    digits = digits
  )
  displayed
}

plot_population_histogram <- function(x, title, x_label) {
  hist(
    x,
    breaks = "FD",
    col = "#8ecae6",
    border = "white",
    main = title,
    xlab = x_label
  )
}

plot_population_bar <- function(x, title, x_label) {
  counts <- table(x)
  barplot(
    counts,
    col = "#8ecae6",
    border = "white",
    main = title,
    xlab = x_label,
    ylab = "Count"
  )
}

plot_mean_histogram <- function(means, sample_size, title) {
  hist(
    means,
    breaks = 35,
    col = "#90be6d",
    border = "white",
    main = paste0(title, ", sample size n = ", sample_size),
    xlab = "Simulated sample mean"
  )
  abline(v = mean(means), col = "#d1495b", lwd = 2)
}

plot_mean_qq <- function(means, sample_size, title) {
  qqnorm(
    means,
    pch = 16,
    cex = 0.35,
    col = rgb(0.12, 0.35, 0.55, 0.35),
    main = paste0(title, ", sample size n = ", sample_size)
  )
  qqline(means, col = "#d1495b", lwd = 2)
}

plot_selected_diagnostics <- function(means_by_size,
                                      selected_sizes,
                                      title) {
  old_par <- par(no.readonly = TRUE)
  on.exit(par(old_par))
  par(mfrow = c(2, 2), mar = c(4, 4, 3, 1))

  for (sample_size in selected_sizes) {
    means <- means_by_size[[as.character(sample_size)]]
    plot_mean_histogram(means, sample_size, title)
  }
}

plot_selected_qq <- function(means_by_size, selected_sizes, title) {
  old_par <- par(no.readonly = TRUE)
  on.exit(par(old_par))
  par(mfrow = c(2, 2), mar = c(4, 4, 3, 1))

  for (sample_size in selected_sizes) {
    means <- means_by_size[[as.character(sample_size)]]
    plot_mean_qq(means, sample_size, title)
  }
}

normal_enough_screen <- function(summary_table) {
  summary_table[summary_table$screening_rule, , drop = FALSE]
}

